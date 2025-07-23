{ lib, config, ... }:

{
    options.mods.audio = {
        enable = lib.mkEnableOption "audio";
    };

    config = lib.mkIf config.mods.audio.enable {
        services.pulseaudio.enable = false;
        security.rtkit.enable = true;
        services.pipewire = {
            enable = true;
            alsa.enable = true;
            alsa.support32Bit = true;
            pulse.enable = true;
        };
    };
}
