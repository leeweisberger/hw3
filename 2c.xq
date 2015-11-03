<result>
  {
    for $p in doc("/opt/dbcourse/examples/xmark/auction.xml")//person
    where $p/address/zipcode=27
    return $p/name
  }
</result>
