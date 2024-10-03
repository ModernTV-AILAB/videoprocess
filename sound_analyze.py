import librosa
import librosa.display
import numpy as np
import matplotlib.pyplot as plt

# Load the audio file
audio_file = 'out.wav'
y, sr = librosa.load(audio_file)

# Amplitude envelope
plt.figure(figsize=(10, 4))
plt.plot(y, label='Amplitude')
plt.title('ano sefe')
plt.xlabel('Time')
plt.ylabel('Amplitude')
plt.savefig('vysledek0.svg')

audio_file = 'ano_sefe2.wav'
y, sr = librosa.load(audio_file)

# Amplitude envelope
plt.figure(figsize=(10, 4))
plt.plot(y, label='Amplitude')
plt.title('ano sefe')
plt.xlabel('Time')
plt.ylabel('Amplitude')
plt.savefig('vysledek0.svg')

# Load the audio file
audio_file = 'reklama1.wav'
y, sr = librosa.load(audio_file)

# Amplitude envelope
plt.figure(figsize=(10, 4))
plt.plot(y, label='Amplitude')
plt.title('reklama')
plt.xlabel('Time')
plt.ylabel('Amplitude')
plt.savefig('vysledek0.svg')

audio_file = 'reklama2.wav'
y, sr = librosa.load(audio_file)

# Amplitude envelope
plt.figure(figsize=(10, 4))
plt.plot(y, label='Amplitude')
plt.title('reklana')
plt.xlabel('Time')
plt.ylabel('Amplitude')
plt.savefig('vysledek0.svg')