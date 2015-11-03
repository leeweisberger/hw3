<result>
  {
	for $p in doc("/opt/dbcourse/examples/xmark/auction.xml")//person
	where (some $c in doc("/opt/dbcourse/examples/xmark/auction.xml")//closed_auction 
		satisfies sum($c[buyer/@person=$p/@id]/price)>0 and sum($c[buyer/@person=$p/@id]/price)<10)
	return $p/name
  }
</result>
