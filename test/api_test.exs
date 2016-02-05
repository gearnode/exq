defmodule ApiTest do
  use ExUnit.Case
  import ExqTestUtil
  alias Exq.Redis.JobStat

  setup do
    TestRedis.setup
    Exq.start_link
    on_exit fn ->
      wait
      TestRedis.teardown
    end
    :ok
  end

  test "queues when empty" do
    assert {:ok, []} = Exq.Api.queues(Exq.Api)
  end

  test "queues when present" do
    Exq.enqueue(Exq, 'custom', Bogus, [])
    assert {:ok, ["custom"]} = Exq.Api.queues(Exq.Api)
  end

  test "remove invalid queue" do
    assert :ok = Exq.Api.remove_queue(Exq.Api, "custom")
  end

  test "remove queue" do
    Exq.enqueue(Exq, "custom", Bogus, [])
    assert {:ok, ["custom"]} = Exq.Api.queues(Exq.Api)
    assert :ok = Exq.Api.remove_queue(Exq.Api, "custom")
    assert {:ok, []} = Exq.Api.queues(Exq.Api)
  end

  test "busy processes when empty" do
    assert {:ok, 0} = Exq.Api.busy(Exq.Api)
  end

  test "busy processes when processing" do
    Exq.enqueue(Exq, 'custom', Bogus, [])
    JobStat.add_process(:testredis, "test", %Exq.Stats.Process{pid: self})
    assert {:ok, 1} = Exq.Api.busy(Exq.Api)
  end

  test "stats when empty" do
    assert {:ok, nil} = Exq.Api.stats(Exq.Api, "processed")
  end

  @tag :pending
  test "stats with data" do
    assert {:ok, 1} = Exq.Api.stats(Exq.Api, "failed")
    assert {:ok, 1} = Exq.Api.stats(Exq.Api, "processed")
  end

  test "jobs when empty" do
    assert {:ok, []} = Exq.Api.jobs(Exq.Api)
  end

  @tag :pending
  test "jobs when enqueued" do
    assert {:ok, [1,2,3]} = Exq.Api.jobs(Exq.Api)
  end

  test "jobs for queue when empty" do
    assert {:ok, []} = Exq.Api.jobs(Exq.Api, 'custom')
  end

  @tag :pending
  test "jobs for queue when enqueued" do
    assert {:ok, [1,2,3]} = Exq.Api.jobs(Exq.Api, 'custom')
  end

  @tag :pending
  test "find_job when missing" do
    assert {:ok, []} = Exq.Api.find_job(Exq.Api, 'custom', 'not_here')
  end

  @tag :pending
  test "find_job with job" do
    {:ok, jid} = Exq.enqueue(Exq, 'custom', Bogus, [])
    assert {:ok, []} = Exq.Api.find_job(Exq.Api, 'custom', jid)
  end

  test "failed when empty" do
    assert {:ok, []} = Exq.Api.failed(Exq.Api)
  end

  @tag :pending
  test "failed with data" do
    assert {:ok, [1,2,3]} = Exq.Api.failed(Exq.Api)
  end

  @tag :pending
  test "queue size" do
  end

  @tag :pending
  test "scheduled queue size" do
  end

  @tag :pending
  test "retry queue size" do
  end

  @tag :pending
  test "retry failed" do
  end

  @tag :pending
  test "clear retry queue" do
  end

  @tag :pending
  test "find job in retry queue" do
  end

  @tag :pending
  test "remove job in retry queue" do
  end

  @tag :pending
  test "clear scheduled queue" do
  end

  @tag :pending
  test "find job in scheduled queue" do
  end

  @tag :pending
  test "remove job in scheduled queue" do
  end

  @tag :pending
  test "realtime stats" do
  end
end
