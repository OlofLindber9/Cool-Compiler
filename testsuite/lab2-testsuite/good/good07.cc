int main ()
{
  let int x = readInt () ;

  let int d = x/2 ;

  while (d > 1) {
    if (d * (x/d) == x)
      printInt(d) ;
    else
      {}

    d-- ;
  }

  return 0;
}
