defmodule Exq.Api do
  @moduledoc """
  Interface for retrieving Exq stats.
  Pid is currently Exq.Api process
  """

  def start_link(opts \\ []) do
    Exq.start_link(Keyword.put(opts, :mode, :api))
  end

  @doc """
  List of queues with jobs (empty queues are deleted)

  Expected args:
    * `pid` - Exq.Api process

  Returns:
  * `{:ok, queues}` - list of queue
  """
  def queues(pid) do
    GenServer.call(pid, :queues)
  end

  @doc """
  Clear / Remove queue

  Expected args:
    * `pid` - Exq.Api process
    * `queue` - Queue name

  Returns:
  * `{:ok, queues}` - list of queue
  """
  def remove_queue(pid, queue) do
    GenServer.call(pid, {:remove_queue, queue})
  end


  @doc """
  Number of busy workers

  Expected args:
    * `pid` - Exq.Api process

  Returns:
  * `{:ok, num_busy}` - number of busy workers
  """
  def busy(pid) do
    GenServer.call(pid, :busy)
  end

  @doc """
  Return stat for given key
  Examples of keys are `processed`, `failed`

  Expected args:
    * `pid` - Exq.Api process
    * `key` - Key for stat
    * `queue` - Queue name

  Returns:
  * `{:ok, stat}` stat for key
  """
  def stats(pid, key) do
    GenServer.call(pid, {:stats, key})
  end
  def stats(pid, key, date) do
    GenServer.call(pid, {:stats, key, date})
  end

  def processes(pid) do
    GenServer.call(pid, :processes)
  end

  def clear_processes(pid) do
    GenServer.call(pid, :clear_processes)
  end

  def jobs(pid) do
    GenServer.call(pid, :jobs)
  end
  def jobs(pid, queue) do
    GenServer.call(pid, {:jobs, queue})
  end

  def find_job(pid, queue, jid) do
    GenServer.call(pid, {:find_job, queue, jid})
  end

  def failed(pid) do
    GenServer.call(pid, :failed)
  end

  def remove_failed(pid, jid) do
    GenServer.call(pid, {:remove_failed, jid})
  end

  def clear_failed(pid) do
    GenServer.call(pid, :clear_failed)
  end

  def retry_failed(pid, jid) do
    GenServer.call(pid, {:retry_failed, jid})
  end

  def find_failed(pid, jid) do
    GenServer.call(pid, {:find_failed, jid})
  end

  def retries(pid) do
    GenServer.call(pid, :retries)
  end

  def scheduled(pid) do
    GenServer.call(pid, {:jobs, :scheduled})
  end

  def queue_size(pid) do
    GenServer.call(pid, :queue_size)
  end
  def queue_size(pid, :scheduled) do
    GenServer.call(pid, {:queue_size, :scheduled})
  end
  def queue_size(pid, queue) do
    GenServer.call(pid, {:queue_size, queue})
  end

  def realtime_stats(pid) do
    GenServer.call(pid, :realtime_stats)
  end
end
