// Simple example effect:
// Draws a noise pattern modulated by an expanding sine wave.

#include "lib/effect_runner.h"
#include "ball.h"

int main(int argc, char **argv)
{
    EffectRunner r;

    BallEffect e;
    r.setEffect(&e);

    // Defaults, overridable with command line options
    r.setLayout("../layouts/grid32x16z.json");

    return r.main(argc, argv);
}