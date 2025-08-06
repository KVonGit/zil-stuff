import struct

def wrap_infocom_snd(input_file, output_file, sample_rate=41000, repeats=4, base_note=0x3C):
    with open(input_file, "rb") as f:
        data = f.read()

    data_len = len(data)
    total_len = 10 + data_len  # total file length
    snd_len = total_len - 2    # length of everything after the first 2 bytes

    with open(output_file, "wb") as f:
        # Prefix: total length after this field (2 bytes)
        f.write(struct.pack(">H", snd_len))

        # Header
        f.write(struct.pack(">B", repeats))         # Repeats: 1 = play once
        f.write(struct.pack(">B", base_note))       # Base note (0x3C = middle C)
        f.write(struct.pack(">H", sample_rate))     # Sample rate (e.g. 34000)
        f.write(struct.pack(">H", 0))               # Unused (2 bytes)
        f.write(struct.pack(">H", data_len))        # Data length

        # Audio data (8-bit unsigned)
        f.write(data)

    print(f"✅ Wrote {output_file} ({data_len} bytes of audio, {sample_rate} Hz, repeat={repeats})")

# Example usage:
wrap_infocom_snd("output.raw", "sound01.snd")