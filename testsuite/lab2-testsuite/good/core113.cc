int f(int x) {
  let int y ;
  if (x < 100) {
    let int x = 91;
    y = x;
  } else {
    y = x;
  }
  return y ;
}

int main() {
  printInt(f(45));
  printInt(f(450));
  return 0;
}
