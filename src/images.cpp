// Simple example for EffectMixer. Mixers let you run multiple effects, and they
// handle concurrent rendering on multiple CPU cores.

#include "lib/effect_runner.h"
#include "lib/effect_mixer.h"

#include "dot.h"

#include "rings.h"

int main(int argc, char **argv)
{
    RingsEffect rings("data/glass.png");
    DotEffect img0("external/img0.png");
    DotEffect img1("external/img1.png");
    DotEffect img2("external/img2.png");
    DotEffect img3("external/img3.png");
    DotEffect img4("external/img4.png");

    
    EffectMixer mixer;
    mixer.add(&rings);
    mixer.add(&img0);
    mixer.add(&img1);
    mixer.add(&img2);
    mixer.add(&img3);
    mixer.add(&img4);

    EffectRunner r;
    r.setEffect(&mixer);
    r.setLayout("../../../Active/layout/layout-60x24.json");
    if (!r.parseArguments(argc, argv)) {
        return 1;
    }

    float state = 0;

    while (true) {
        EffectRunner::FrameStatus frame = r.doFrame();
        const float speed = 0.1f;

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