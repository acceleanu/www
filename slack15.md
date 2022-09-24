# slack15 config

[no sound solution](https://www.linuxquestions.org/questions/slackware-14/slackware-15-0-no-sound-4175709191/)

```
dmesg | grep -i sof 
[    0.562182] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.637572] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.637705] software IO TLB: mapped [mem 0x0000000061ea9000-0x0000000065ea9000] (64MB)
[    4.584768] snd_hda_intel 0000:00:1f.3: Digital mics found on Skylake+ platform, using SOF driver
[    4.730690] snd_soc_skl 0000:00:1f.3: Digital mics found on Skylake+ platform, using SOF driver
[    4.820250] sof-audio-pci-intel-cnl 0000:00:1f.3: DSP detected with PCI class/subclass/prog-if info 0x040380
[    4.822362] sof-audio-pci-intel-cnl 0000:00:1f.3: Digital mics found on Skylake+ platform, using SOF driver
[    4.825072] sof-audio-pci-intel-cnl 0000:00:1f.3: DSP detected with PCI class/subclass/prog-if 0x040380
[    4.841440] sof-audio-pci-intel-cnl 0000:00:1f.3: bound 0000:00:02.0 (ops i915_audio_component_bind_ops [i915])
[    4.848324] sof-audio-pci-intel-cnl 0000:00:1f.3: use msi interrupt mode
[    4.886919] sof-audio-pci-intel-cnl 0000:00:1f.3: hda codecs found, mask 5
[    4.886942] sof-audio-pci-intel-cnl 0000:00:1f.3: using HDA machine driver skl_hda_dsp_generic now
[    4.886963] sof-audio-pci-intel-cnl 0000:00:1f.3: DMICs detected in NHLT tables: 2
[    4.887275] sof-audio-pci-intel-cnl 0000:00:1f.3: Direct firmware load for intel/sof/sof-cml.ri failed with error -2
[    4.887300] sof-audio-pci-intel-cnl 0000:00:1f.3: error: sof firmware file is missing, you might need to
[    4.887319] sof-audio-pci-intel-cnl 0000:00:1f.3:        download it from https://github.com/thesofproject/sof-bin/
[    4.887340] sof-audio-pci-intel-cnl 0000:00:1f.3: error: failed to load DSP firmware -2
[    4.905281] sof-audio-pci-intel-cnl 0000:00:1f.3: error: sof_probe_work failed err: -2

```

[install firmware](https://github.com/thesofproject/sof-bin/blob/main/README.md)


