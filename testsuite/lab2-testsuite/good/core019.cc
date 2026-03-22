int main() {
  let int i = 78;
  {
    let int i = 1;
    printInt(i);
  }
  printInt(i);
  while (i > 76) {
    i--;
    printInt(i);
   let int i = 7;
   printInt(i);
  }
  printInt(i);
  if (i > 4) {
    let int i = 4;
    printInt(i);
  } else {

  }
  printInt(i);
  return 0 ;

}
