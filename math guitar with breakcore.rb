use_bpm 80
use_debug false
use_random_seed 49

drum_amp = 2
fx_amb = 2
guitar_amp = 0.5
second_guitar_amp = 0.2
bass_amp = 1.5

define :breakbeat do
  live_loop :drums do
    sample :loop_amen, beat_stretch: 2, amp: drum_amp
    sleep 2
  end
end

define :drum_variations do
  live_loop :drum_fills, sync: :drums do
    with_fx :slicer, phase: 0.125, wave: 1 do
      sample :loop_amen, beat_stretch: 2, rate: [1, -1, 0.5, -0.75].choose, amp: drum_amp * 0.8
    end
    sleep 4
  end
end

define :fx_ambience do
  live_loop :reverb_wash, sync: :drums do
    with_fx :reverb, mix: 0.7, room: 0.8 do
      with_fx :echo, phase: 0.25, mix: 0.5 do
        sample :ambi_drone, rate: [0.5, 0.75, 1].choose, amp: fx_amb
        sleep 8
      end
    end
  end
end

define :fx_glitch do
  live_loop :glitches, sync: :drums do
    sample :glitch_bass_g, rate: rrand(-1, 1), start: 0.1, finish: 0.3, amp: rrand(0.4, 0.8)
    sleep [0.25, 0.5].choose
  end
end

define :electronic_guitar do
  live_loop :guitar, sync: :drums do
    use_synth :pluck
    with_fx :reverb, mix: 0.6, room: 0.9 do
      with_fx :distortion, distort: 0.3 do
        melody = (ring :e4, :g4, :b4, :d5, :f4, :e4, :d4).shuffle
        play melody.tick, release: 0.5, amp: guitar_amp, cutoff: rrand(80, 120)
        sleep 0.25
      end
    end
  end
end

define :breakcore_guitar do
  live_loop :second_guitar, sync: :drums do
    use_synth :prophet
    with_fx :bitcrusher, bits: 6, mix: 0.7 do
      with_fx :echo, phase: 0.125, decay: 1 do
        notes = (scale :e3, :minor_pentatonic).shuffle.take(4)
        4.times do
          play notes.choose, release: 0.2, amp: second_guitar_amp, cutoff: rrand(90, 110)
          sleep [0.125, 0.25].choose
        end
      end
    end
  end
end

define :bassline do
  live_loop :bass, sync: :drums do
    use_synth :fm
    with_fx :lpf, cutoff: 80 do
      bass_notes = (ring :e2, :g2, :b1, :d2, :f2, :e2, :d2)
      play bass_notes.tick, release: 0.5, amp: bass_amp
      sleep 0.5
    end
  end
end

breakbeat
drum_variations
fx_ambience
fx_glitch
electronic_guitar
breakcore_guitar
bassline

