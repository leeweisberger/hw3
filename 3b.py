#!/usr/bin/env python

import sys
reload(sys)
sys.setdefaultencoding('utf-8')

from xml.dom.minidom import parse, getDOMImplementation
def makeHouseSenate(n, newDom):
	house = newDom.createElement('house')
	senate = newDom.createElement('senate')
	
	senators=[]
	getPeople(n.childNodes[0].childNodes[1].childNodes[1],newDom,senators,"sen")
	reps=[]
	getPeople(n.childNodes[0].childNodes[1].childNodes[1],newDom,reps,"rep")
	for senator in senators:
		addCommittees(senator, n.childNodes[0].childNodes[3].childNodes[1],newDom,senator)
		senator.removeAttribute('id')
		senate.appendChild(senator)
	for rep in reps:
		addCommittees(rep, n.childNodes[0].childNodes[3].childNodes[1],newDom,rep)
		rep.removeAttribute('id')
		house.appendChild(rep)
	

	newDom.documentElement.appendChild(house)
	newDom.documentElement.appendChild(senate)

def addCommittees(person, n, newDom, addTo):
	if n.nodeType == n.TEXT_NODE:
		n = n.nextSibling
	if n==None or n.childNodes.length==0:
		return
	if n.nodeName=='committee' or n.nodeName=='subcommittee':
		member = n.childNodes[1]

		while member.nodeType != n.ELEMENT_NODE or person.getAttribute('id')!=member.getAttribute('id'):
			member = member.nextSibling
			
			if member==None: break  
		if member!=None and person.getAttribute('id')==member.getAttribute('id'):
			e = newDom.createElement(n.nodeName)
			e.setAttribute('name', n.getAttribute('displayname'))
			if member.hasAttribute('role'):
				e.setAttribute('role', member.getAttribute('role'))
			else:
				e.setAttribute('role', 'Member')
			addTo.appendChild(e)
			while member!=None:			
				if member.nodeName=='subcommittee':
					addCommittees(person, member, newDom, e)
				member=member.nextSibling
		if(n.nodeName=='committee'):addCommittees(person, n.nextSibling, newDom, addTo)

	

def getPeople(n, newDom, people, str):	
	if n.nodeType == n.TEXT_NODE:
		n = n.nextSibling
	if n==None:
		return
	if n.nodeName=='person':
		role = n.childNodes[1]
		while not (role.nodeType == n.ELEMENT_NODE and role.hasAttribute('current')):
			role = role.nextSibling

		if role.hasAttribute('current') and role.getAttribute('current')=='1':
			if role.getAttribute('type')==str:
				e = newDom.createElement('person')
				e.setAttribute('name', n.getAttribute('name'))
				e.setAttribute('id', n.getAttribute('id'))
				people.append(e)
		getPeople(n.nextSibling, newDom, people, str)

def makeDom(n, newDom):
	makeHouseSenate(n, newDom)



dom = parse(sys.stdin)
newdom = getDOMImplementation().createDocument(None, 'congress', None)
makeDom(dom, newdom)
print newdom.toprettyxml()
