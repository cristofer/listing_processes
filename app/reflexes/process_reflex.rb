class ProcessReflex < StimulusReflex::Reflex
  def list
    @list_of_processes = convert_processes
  end

  private

  def convert_processes
    processes_parsed.map do |process|
      {
        user: process[0],
        pid: process[1],
        cpu: process[2],
        mem: process[3],
        status: process[7],
        started: process[8],
        time: process[9],
        command: process[10]
      }
    end
  end

  def processes_parsed
    processes.split(/\n/).map { |process| process.split(' ') }
  end

  def processes
    `ps aux | sort -nrk 3 | head -20`
  end
end
