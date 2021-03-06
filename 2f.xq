(:Find names of all persons with address in “United States” who never bought anything in
closed auctions.:)

<result>
  {
    for $p in doc("/opt/dbcourse/examples/xmark/auction.xml")//person
	where $p/address/country='United States' and
	not (some $c in doc("/opt/dbcourse/examples/xmark/auction.xml")//closed_auction
	     satisfies ($c/buyer/@person=$p/@id)) 


    return $p/name
  }
</result>
