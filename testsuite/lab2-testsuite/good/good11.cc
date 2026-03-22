//read numbers until 0 is read, and print their average

int main ()
{
  let int sum = 0 ;
  let int num = 0 ;
  let int x ;
  while ((x = readInt()) != 0) {
    sum = sum + x ;
    num++ ;
  }
  printInt(sum/num) ;

  return 0;
}
