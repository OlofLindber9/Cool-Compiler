void   printint(int x)       { printInt(100+x);     }
void   printdouble(double x) { printDouble(99.0+x); }
int    readint()             { return 0;            }
double readdouble()          { return 1.0;          }

int main() {
  let int    x = readint();
  let double X = readdouble();
  printint(x);
  printdouble(X);
  return 0;
}
