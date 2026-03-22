int main() {
  let int a = 0;
  let int b; b = a;

  ++b;
  printInt(a);

  b++;
  printInt(a);

  --b;
  printInt(a);

  b--;
  printInt(a);

  b = 832;
  printInt(a);

  return 0;
}
