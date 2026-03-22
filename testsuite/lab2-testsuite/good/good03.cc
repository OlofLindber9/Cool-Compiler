int main ()
{
  let int arg = readInt() ;
  let int ret = 1 ;

  let int i = 1 ;

  while (i < arg + 1) {
    ret = i * ret ;
    ++i ;
  }
  printInt(ret) ;

  return 0;
}
