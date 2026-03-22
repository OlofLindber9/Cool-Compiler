int main () {
  let bool var = true;

  let int n = 0;
  while (n++ < 1) int var = 1;

  // Make sure var is still a bool
  var == true;
  let bool var2 = var;

  return 0;
}
