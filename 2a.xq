<result>
  {
    for $a in doc("/opt/dbcourse/examples/xmark/auction.xml")//africa
    return $a/item/name
  }
</result>
