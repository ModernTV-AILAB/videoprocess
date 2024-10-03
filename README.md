[![Documentation](https://img.shields.io/badge/docs-available-brightgreen.svg)](https://moderntv-ailab.github.io/videoprocess/)



# Videoprocess

Wrapper for ffmpeg, requires ffmpeg to be available on path (https://www.ffmpeg.org/)

## Installation

Not available in hex due to legal reasons, use:
```
mix deps.get
```
and
```
mix test
```
or
```
mix run example/example.exs
```

## Usage

for running examples, refer to example/ folder and use

```
mix run example.exs
```

---

# Multimedia Processing with Elixir

This document provides an example of how to use Elixir functions to process video and audio data. Below are the steps to split, concatenate, and extract audio/video/images from multimedia files using Elixir modules and functions.

## Prerequisites

Ensure you have the following modules available:
- `Videoprocess`: Handles various video and audio processing operations.
- `FileListCreator`: Helps create file lists for concatenation.
- `Runner`: Executes commands for processing.

## Usage Examples

### 1. Splitting a Video File

Split a `.ts` video file into 10-second segments.

```elixir
Videoprocess.split_multimedia("example/input/input01_ocean.ts", "example/output", 10) 
|> Runner.run_porcelain_command
```

- **Input**: `"example/input/input01_ocean.ts"`
- **Output Directory**: `"example/output"`
- **Split Duration**: `10` seconds per segment

### 2. Creating a File List of Split Segments

Create a list of `.ts` files in the output directory for further processing.

```elixir
files = FileListCreator.list_ts_files("example/output") |> IO.inspect
FileListCreator.create_file_list(files, "example/output/filelist/filelist.txt")
```

- **Directory to Search**: `"example/output"`
- **File List Output**: `"example/output/filelist/filelist.txt"`

### 3. Concatenating the Split Segments

Concatenate the split segments back into a single file.

```elixir
Videoprocess.concat_multimedia("example/output/filelist/filelist.txt", "example/output/concat/concat.ts") 
|> Runner.run_porcelain_command
```

- **File List Input**: `"example/output/filelist/filelist.txt"`
- **Concatenated Output**: `"example/output/concat/concat.ts"`

### 4. Saving Images from a Video

Save images from the first video segment (or any specified `.ts` file) at a specific interval.

```elixir
Videoprocess.save_images(Enum.at(files, 0), "example/output/images", 1) 
|> Runner.run_porcelain_command
```

- **Video Input**: The first file from the `files` list.
- **Output Directory**: `"example/output/images"`
- **Frames per Second (FPS)**: `1` frame per second

### 5. Extracting Images from Multiple Video Segments

Extract images from a list of video segments, saving them to an output folder with a specified FPS.

```elixir
Videoprocess.save_images_map(%{
  video: files, 
  outfolder: "example/output/imagesmap", 
  fps: 100
}) 
|> Runner.run_commands_parallel
```

- **Video Input List**: `files` (list of `.ts` files)
- **Output Directory**: `"example/output/imagesmap"`
- **Frames per Second (FPS)**: `100` frames per second

### 6. Extracting Audio Only

Extract only the audio track from the original `.ts` video file and save it as a `.wav` file.

```elixir
Videoprocess.save_audio("example/input/input01_ocean.ts", "example/output/audio", ".wav") 
|> Runner.run_porcelain_command
```

- **Video Input**: `"example/input/input01_ocean.ts"`
- **Audio Output Directory**: `"example/output/audio"`
- **Audio Format**: `.wav`

### 7. Extracting Video Only

Extract only the video track from the original `.ts` video file and save it as an `.mp4` file.

```elixir
Videoprocess.save_video("example/input/input01_ocean.ts", "example/output/video", ".mp4") 
|> Runner.run_porcelain_command
```

- **Video Input**: `"example/input/input01_ocean.ts"`
- **Video Output Directory**: `"example/output/video"`
- **Video Format**: `.mp4`

## Summary

This example shows how to:
- Split a video file into segments.
- Generate a file list for concatenation.
- Concatenate video segments back together.
- Extract images at a specified frame rate.
- Extract audio and video separately.

Each function provided by the `Videoprocess` module can be run as shown, with parameters tailored to the type of multimedia processing required.
