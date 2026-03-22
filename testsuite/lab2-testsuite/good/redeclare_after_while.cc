// Extra scope for while body needed.

int main() {
  let int n = 0;
  while (n++ < 10) int m = 100;
  let int m = n;
  printInt(m);  // Should print 11
  return 0;
}
