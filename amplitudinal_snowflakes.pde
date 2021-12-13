import processing.sound.*;

// Declare the processing sound variables 
SoundFile sample;
Amplitude rms;

int max = 14; //set max time in seconds

float scaleFactor = 1;
// Declare a smooth fctor to smooth out sudden changes in amplitude.
// With a smooth factor of 1, only the last measured amplitude is used for the
// visualisation, which can lead to very abrupt changes. As you decrease the
// smooth factor towards 0, the measured amplitudes are averaged across frames,
// leading to more pleasant gradual changes
float smoothingFactor = 0.25;

// Used for storing the smoothed amplitude value
float sum;

float xOff = 0;

int frames = 0;
float amplitude;
float oldAmplitude;
float time;

void setup() {
  size(1000,1000);
  frameRate(30);
  max = max * 30; //set in terms of framerate
  background(0);
  //colorMode(HSB, 100);
    //Load and play a soundfile and loop it
  sample = new SoundFile(this, "esnow1.wav");
  sample.play();

  // Create and patch the rms tracker
  rms = new Amplitude(this);
  rms.input(sample);
}

void draw() {
  frames++;
  
  if (frames >= max){ //looping snowflake
    //frames = 0;
    //background(0);
  }
  //background(0);s
  // smooth the rms data by smoothing factor
  sum += (rms.analyze() - sum) * smoothingFactor;

  // rms.analyze() return a value between 0 and 1. It's
  // scaled to height/2 and then multiplied by a fixed scale factor
  scaleFactor = map(frames, 0, max, 1, 1);
  float rms_scaled = sum * (height/12) * scaleFactor;
  
  translate(width/2, height/2);
  time = map(frames, 0, max, 0, -width/2); 
  println(time);
  float amplitude = rms_scaled;
  //float py = oldAmplitude - height * 0.5;
  //float oldTime = (frames-1) - width * 0.5;
  float angle = 360 / 12;
  
  //if(frames % 2 == 0){
    for (int i = 0; i < 12; i++) {
      push();
      rotate( i * radians(angle));
  
      stroke(255);
      //float d = dist(time,amplitude,oldTime,py);
      //float sw = map(d,0,20,10,1);
      strokeWeight(2);
      
      noFill();
      rect(time,amplitude,amplitude/6, amplitude/6);
      //line(0,0,time,amplitude);
      scale( -1, 1);
      //line(time,amplitude,time-1,oldAmplitude);
      rect(time,amplitude,amplitude/6, amplitude/6);
      //stroke(0);
      //scale( 1, 1);
      //line(time,amplitude,time-1,oldAmplitude);
      //scale( -1, 1);
      //line(time,amplitude,time-1,oldAmplitude);
      //line(0,0,time,amplitude);
      pop();
    }
  //}
  oldAmplitude = amplitude;
  
  //xOff+=0.1;
}
