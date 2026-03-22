int fac (int a) {
  let int r;
  let int n;
  r = 1;
  n = a;
  while (n > 0)
  {
    r = r * n;
    n = n - 1;
  }
  return r;
}

int main() {
  printInt(fac(5));
  return 0 ;
}
