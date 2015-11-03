<congress>
  {	
	let $x := 5
	return

		<house>	
			{ for $person in //person
			
			let $role := $person/role[@current=1]/@type
			
			return if($role='rep') 
				then <person name="{$person/@name}"> 
					{for $committee in //committee[member[@id=$person/@id]]
					let $member := $committee/member[@id=$person/@id]
					

					return <committee name="{$committee/@displayname}" 
						role="{if($member/@role) then ($member/@role) else('Member')}">
							
								{for $subcommittee in $committee//subcommittee[member[@id=$person/@id]]
								let $member := $subcommittee/member[@id=$person/@id]
								return <subcommittee name="{$subcommittee/@displayname}"
								role="{if($member/@role) then ($member/@role) else('Member')}">
								</subcommittee>}
						</committee>}
				</person> 
				else() }
		</house>
}
{
		<senate>	
			{ for $person in //person
			let $role := $person/role[@current=1]/@type
			return if($role='sen') 
				then <person name="{$person/@name}"> 
					{for $committee in //committee[member[@id=$person/@id]]
					let $member := $committee/member[@id=$person/@id]
					return <committee name="{$committee/@displayname}" 
						role="{if($member/@role) then ($member/@role) else('Member')}">
							
								{for $subcommittee in $committee//subcommittee[member[@id=$person/@id]]
								let $member := $subcommittee/member[@id=$person/@id]
								return <subcommittee name="{$subcommittee/@displayname}"
								role="{if($member/@role) then ($member/@role) else('Member')}">
								</subcommittee>}
						</committee>}
				</person> 
				else() }
		</senate>

  }
</congress>
