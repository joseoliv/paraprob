int gcd(int a, int b) {
  return b == 0 ? a : gcd(b, a % b);
}

(int, int) simplifyFraction((int, int) fraction) {
  if (fraction.$1 == 0) return (0, 1);
  if (fraction.$2 == 0) {
    return (1, 0); // Error case, should not happen with valid inputs
  }
  int common = gcd(fraction.$1.abs(), fraction.$2.abs());
  return (fraction.$1 ~/ common, fraction.$2 ~/ common);
}

(int, int) addFractions((int, int) f1, (int, int) f2) {
  if (f1.$2 == 0 || f2.$2 == 0) return (1, 0); // Error
  int numerator = f1.$1 * f2.$2 + f2.$1 * f1.$2;
  int denominator = f1.$2 * f2.$2;
  if (denominator == 0) return (1, 0); // Should not happen
  return simplifyFraction((numerator, denominator));
}

(int, int) parseFraction(String text, int index) {
  final regex = RegExp(r'^\s*(\d+)\s*/\s*(\d+)\s*$');
  final match = regex.firstMatch(text);
  if (match != null) {
    int n = int.parse(match.group(1)!);
    int m = int.parse(match.group(2)!);
    if (m == 0) {
      // Handle division by zero error for this specific field
      throw Exception('Denominator cannot be zero for $index');
    }
    if (m < 0) {
      // Ensure denominator is positive
      n = -n;
      m = -m;
    }
    return (n, m);
  }
  throw Exception('Invalid format for $index');
}

(int, int) div((int, int) a, (int, int) b) {
  if (b.$1 == 0) {
    return (1, 0); // Error case, should not happen with valid inputs
  }
  return simplifyFraction((a.$1 * b.$2, a.$2 * b.$1));
}

(int, int) sub((int, int) a, (int, int) b) {
  if (a.$2 == 0 || b.$2 == 0) return (1, 0); // Error
  int numerator = a.$1 * b.$2 - b.$1 * a.$2;
  int denominator = a.$2 * b.$2;
  if (denominator == 0) return (1, 0); // Should not happen
  return simplifyFraction((numerator, denominator));
}

bool gt( (int, int) a, (int, int) b) {
  if (a.$2 == 0 || b.$2 == 0) return false; // Error case
  return a.$1 * b.$2 > b.$1 * a.$2;
}
