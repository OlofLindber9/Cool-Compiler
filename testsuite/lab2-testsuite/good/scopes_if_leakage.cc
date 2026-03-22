int main () {
  let bool var = true;

  if (true) int var = 1; else int var = 0;

  // Make sure var is still a bool
  var == true;
  let bool var1 = var;

  if (false) int var = 1; else int var = 0;

  // Make sure var is still a bool
  var == true;
  let bool var2 = var;

  return 0;
}
