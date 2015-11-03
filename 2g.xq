(:For each open auction whose seller’s name is “Venkatavasu Takano”, print out the
following information: 
<open_auction id="...">
 <bidders total_number="...">
 <bidder_name>...</bidder_name>
 <bidder_name>...</bidder_name> ...
 </bidders>
</open_auction>:)

<result>
  {
    for $o in doc("/opt/dbcourse/examples/xmark/auction.xml")//open_auction
	where $o/seller/@person = doc("/opt/dbcourse/examples/xmark/auction.xml")//person[name='Venkatavasu Takano']/@id
	return
	<open_auction id="{$o/@id}">
		<bidders total_number="{count($o/bidder)}">
		{for $bidder in $o/bidder
			let $pname := doc("/opt/dbcourse/examples/xmark/auction.xml")//person[@id=$bidder/personref/@person]/name
			return <bidder_name>"{string($pname)}"</bidder_name>
		}
		</bidders>
	</open_auction>
  }
</result>
