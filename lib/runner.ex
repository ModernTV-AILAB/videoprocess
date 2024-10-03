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
    result = Porcelain.shell(command, out: :string)

    if result.status != 0 do
      Logger.error("Command failed: #{command}")
      Logger.error("Error: #{inspect(result)}")
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
