// Simple example for EffectMixer. Mixers let you run multiple effects, and they
// handle concurrent rendering on multiple CPU cores.

#include "lib/effect_runner.h"
#include "lib/effect_mixer.h"
#include "lib/tinydir.h"

#include "video.h"
#include "particle_trail.h"
#include "rings.h"

int main(int argc, char **argv)
{

    EffectMixer mixer;

    VideoEffect video("/Users/matt//active/video/queue/");

    mixer.add(&video);

          
    EffectRunner r;
    r.setEffect(&mixer);
    r.setMaxFrameRate(30);

    r.setLayout("../../../Active/layout/layout-60x24.json");
    if (!r.parseArguments(argc, argv)) {
        return 1;
    }

    float state = 0;

    while (true) {
        EffectRunner::FrameStatus frame = r.doFrame();
        const float speed = 10.0f; //FAST
       // const float speed = 0.001f; //SLOW

/*
       // Animate the mixer's fader controls
        state = fmod(state + frame.timeDelta * speed, 2 * M_PI);
        for (int i = 0; i < mixer.numChannels(); i++) {
            float theta = state + i * (2 * M_PI) / mixer.numChannels();
            mixer.setFader(i, std::max(0.0f, sinf(theta)));
        }

        */

        // Animate the mixer's fader controls
  ///*
        state = fmod(state + frame.timeDelta * speed, mixer.numChannels());
        for (int i = 0; i < mixer.numChannels(); i++) {

            mixer.setFader(i, 0.0);

            //float remainder = state - i;
            // is this state
            if ( i == (int)state) {
                mixer.setFader(i, 1.0);
            }

       /*     // is next state
            int nextState = (int) state;
            nextState += 1;
            nextState % mixer.numChannels();
            if (i == nextState) {
                mixer.setFader(i, 1-remainder);
            }
*/
     //       float theta = state + i * (2 * M_PI) / mixer.numChannels();
      //      mixer.setFader(i, std::max(0.0f, sinf(theta)));
        }
      //  */

        // Main loops and Effects can both generate verbose debug output (-v command line option)
        if (frame.debugOutput) {
            fprintf(stderr, "\t[video] state = %f\n", state);
        }
    }



}