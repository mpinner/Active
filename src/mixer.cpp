// Simple example for EffectMixer. Mixers let you run multiple effects, and they
// handle concurrent rendering on multiple CPU cores.

#include "lib/effect_runner.h"
#include "lib/effect_mixer.h"

#include "rings.h"
#include "dot.h"
#include "spokes.h"

#include "snow.h"
#include "ball.h"
#include "video.h"

#include "particle_trail.h"


int main(int argc, char **argv)
{
    RingsEffect rings("data/glass.png");
    VideoEffect video("/Users/matt//active/video/queue/");
    SpokesEffect spokes;
    SnowEffect snow;
    BallEffect ball;
    ParticleTrailEffect particles;


    EffectMixer mixer;
    mixer.add(&particles);
    mixer.add(&video);
    mixer.add(&snow);
    mixer.add(&video);
    mixer.add(&ball);
    mixer.add(&video);
    mixer.add(&rings);
    mixer.add(&video);
//    mixer.add(&spokes);

    EffectRunner r;
    r.setMaxFrameRate(30);
    r.setEffect(&mixer);
    r.setLayout("../../../Active/layout/layout-60x24.json");
    if (!r.parseArguments(argc, argv)) {
        return 1;
    }

    float state = 0;

    while (true) {
        EffectRunner::FrameStatus frame = r.doFrame();
        const float speed = 0.09f;

        // Animate the mixer's fader controls
        state = fmod(state + frame.timeDelta * speed, 2 * M_PI);
        for (int i = 0; i < mixer.numChannels(); i++) {
            float theta = state + i * (2 * M_PI) / mixer.numChannels();
            mixer.setFader(i, std::max(0.0f, sinf(theta)));
        }

        // Main loops and Effects can both generate verbose debug output (-v command line option)
        if (frame.debugOutput) {
            fprintf(stderr, "\t[main] state = %f\n", state);
        }
    }
}