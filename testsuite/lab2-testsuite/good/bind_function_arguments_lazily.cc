int snd (int x, int y) {
  return y;
}

int main () {
  let int x = 0;
  let int r = snd(1,x);
  printInt(r); // Should print 0
  return r;
}
