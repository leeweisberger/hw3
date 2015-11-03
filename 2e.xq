(:Find names of all persons who have bidden in an open auction for an item whose name contains
the string “cow”:)

<result>
  {
    for $p in doc("/opt/dbcourse/examples/xmark/auction.xml")//person


	where (some $o in doc("/opt/dbcourse/examples/xmark/auction.xml")//open_auction 
		satisfies ($o/bidder/personref/@person=$p/@id and
		contains(string(doc("/opt/dbcourse/examples/xmark/auction.xml")//item[@id=$o/itemref/@item]/name),'cow')))

    return $p/name
  }
</result>
