int main() {
  let int x = 50;
  let int y = x+++x--;
  printInt(y);
  printInt(x);
  printInt((x=10)+x+++x);
  printInt(x);
  return 0;
}
