defmodule Newsletter do
  def read_emails(path) do
    File.read!(path)
    |> String.split("\n", [trim: true])
  end

  def open_log(path) do
    File.open!(path, [:write])
  end

  def log_sent_email(pid, email) do
    IO.puts(pid,email)

  end

  def close_log(pid) do
    File.close(pid)
  end

  def send_newsletter(emails_path, log_path, send_fun) do
    emails = read_emails(emails_path)
    pid = open_log(log_path)
    emails
    |> Enum.map(fn x ->
      if send_fun.(x) == :ok do
        log_sent_email(pid, x)
      end
    end)
    close_log(pid)
  end
end
