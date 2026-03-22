// Andreas Abel, 2024-05-27
// Blocks of different size to expose bugs in the `.limit local` counts.

int main () {
  let int a = 0;
  {
    let int x = 1;
    let int y = 2;
    let int z = 3;
    a = x + y + z;
  }
  {
    let int u = 4;
    let int v = 5;
    a = a + u + v;
  }
  {
    let int w = 6;
    a = a + w;
  }
  printInt(a);
}
