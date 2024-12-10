use_bpm 90
use_debug false

kick_amp = 2.5
bass_amp = 2
dark_pad_amp = 1.2
perc_amp = 0.1
noise_amp = 0.1

define :dark_kick do
  live_loop :kick do
    sample :bd_haus, amp: kick_amp, cutoff: 100
    sleep 0.5
  end
end

define :dark_bass do
  live_loop :bass, sync: :kick do
    use_synth :dsaw
    with_fx :distortion, distort: 0.4 do
      with_fx :reverb, mix: 0.6, room: 0.8 do
        play :e1, release: 0.5, sustain: 0.5, amp: bass_amp, cutoff: rrand(50, 90)
        sleep 1
        play :d1, release: 0.5, sustain: 0.5, amp: bass_amp, cutoff: rrand(50, 90)
        sleep 1
      end
    end
  end
end

define :dark_pad do
  live_loop :pads, sync: :kick do
    use_synth :prophet
    with_fx :gverb, mix: 0.7, room: 0.9, release: 8 do
      play :e3, sustain: 8, release: 4, amp: dark_pad_amp
      play :g3, sustain: 8, release: 4, amp: dark_pad_amp * 0.7
      sleep 8
    end
  end
end

define :dark_percussion do
  live_loop :metal_hits, sync: :kick do
    with_fx :echo, phase: 0.375, decay: 2 do
      sample :elec_triangle, rate: rrand(0.8, 1.2), amp: perc_amp if one_in(2)
    end
    sleep 0.5
  end
end

define :noise_fx do
  live_loop :noise, sync: :kick do
    with_fx :band_eq, freq: 100, res: 0.8 do
      sample :ambi_dark_woosh, rate: -1, amp: noise_amp, attack: 2, release: 4
    end
    sleep 8
  end
end

define :dark_lead do
  live_loop :lead, sync: :kick do
    use_synth :blade
    with_fx :reverb, mix: 0.5, room: 0.7 do
      with_fx :echo, phase: 0.25, decay: 2 do
        notes = (ring :e4, :g4, :d4, :f4, :g3, :d3).shuffle
        play notes.tick, release: 0.4, amp: 1.2, cutoff: rrand(90, 120)
        sleep [0.25, 0.5, 0.75].choose
      end
    end
  end
end

dark_kick
dark_bass
dark_pad
dark_percussion
noise_fx
dark_lead