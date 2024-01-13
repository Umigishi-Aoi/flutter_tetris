enum Rotation {
  r0,
  r90,
  r180,
  r270;

  Rotation rotateR90() => switch (this) {
        r0 => r90,
        r90 => r180,
        r180 => r270,
        r270 => r0,
      };

  Rotation rotateL90() => switch (this) {
        r0 => r270,
        r90 => r0,
        r180 => r90,
        r270 => r180,
      };
}
