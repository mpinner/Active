// Simple example for EffectMixer. Mixers let you run multiple effects, and they
// handle concurrent rendering on multiple CPU cores.

#include "lib/effect_runner.h"
#include "lib/effect_mixer.h"

#include "rings.h"
#include "dot.h"
#include "spokes.h"

int main(int argc, char **argv)
{
   // RingsEffect rings("data/glass.png");
   // DotEffect crash("data/crash.png");
  //  DotEffect dance("data/dance-in.png");
 //SpokesEffect spokes;


    EffectMixer mixer;
 ///   mixer.add(&rings);
  //  mixer.add(&crash);
 //   mixer.add(&dance);

/*
DotEffect nyan("data/nyan.png");                                                                                  
mixer.add(&nyan);                                                                                                 

DotEffect crash("data/crash.png");                                                                                
mixer.add(&crash);                                                                                                

DotEffect sky("data/sky.png");                                                                                    
mixer.add(&sky);                                                                                                  

DotEffect glass("data/glass.png");                                                                                
mixer.add(&glass);                                                                                                

DotEffect dot("data/dot.png");                                                                                    
mixer.add(&dot);                                                                                                  

DotEffect dance("data/dance.png");                                                                                
mixer.add(&dance);                                                                                                
*/

DotEffect startingcrow("data/startingcrow.png");                                                                  
mixer.add(&startingcrow);                                                                                         

DotEffect crow("data/crow_up.png");                                                                               
mixer.add(&crow);                                                                                                 

DotEffect crowUp("data/crow_flying_down.png");                                                                      
mixer.add(&crowUp);                                                                                                 

DotEffect gull("data/gull_flying.png");                                                                           
mixer.add(&gull);                                                                                                 

DotEffect flying("data/flying-pelican.png");                                                                      
mixer.add(&flying);                        


DotEffect bruja("data/bruja.png");                                                                                
mixer.add(&bruja);                                                                                                

DotEffect cat("data/cat.png");                                                                                    
mixer.add(&cat);                                                                                                  

DotEffect bat("data/bat.png");                                                                                    
mixer.add(&bat);                                                                                                  


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