defmodule Runner do
  require Logger

  @moduledoc """
    Documentation for `Runner` module.

    Module for executing shell commands
  """

  @doc """
    Main function to run porcelain shell command

    use functions from `Videoprocess` to prepare command

    Error are logged in log/error.log file using `Logger`

  """
  def run_porcelain_command(command) do
    # Redirect stderr to stdout in the shell command
    full_command = "#{command} 2>&1"

    result = Porcelain.shell(full_command, out: :string)

    unless result.status == 0 do
      Logger.error("Command failed with status #{result.status}")
      Logger.error("Error Output: #{result.out}")
    end
  end

  @doc """
    Main function to run multiple porcelain shell commands in parallel

    use functions from `Videoprocess` to prepare command

  """
  def run_commands_parallel(commands) do
    commands
    |> Enum.map(&Task.async(fn -> run_porcelain_command(&1) end))
    |> Task.await_many(:infinity)
  end

  @doc """
    This loads metadata and return json to console

  """
  def get_metadata(file_path) do
    %{out: res} =
      Porcelain.shell(
        "ffprobe -v quiet -print_format json -show_format -show_streams #{file_path}",
        out: :string
      )

    {:ok, json} = Jason.decode(res)
    json
  end
end
