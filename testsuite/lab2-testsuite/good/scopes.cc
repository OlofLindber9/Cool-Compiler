
int f() {
  let int n = 2;
  if (n < 3) {
    let int n = 3;
    return n;
  } else { }
  return n;
}

int main() {
  let int n = 1;
  printInt(n);
  printInt(f());
  printInt(n);
  return 0;
}
