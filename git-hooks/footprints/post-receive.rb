# This is a ruby based post-receive hook to e-mail footprints some shit, it's made to work with the existing Ruby post-receive hook from
# Git lab
require 'shellwords'

info = refs.split(' ')
revisions = `git rev-parse #{info.at(2)} | git rev-list --stdin #{info.at(0)}..#{info.at(1)}`.split("\n")
for index in 0 ... revisions.size
        rev = revisions[index]
        log = `git log #{rev}~1..#{rev} | sed '1,3d'`
        log.delete!("\n")
        if log.include? "#"
                issue = log.scan(/.*#(\d+).*\Z/).last.first
                subject = "GITLAB Automated message ISSUE=#{issue} PROJ=72"
                cmd = "echo #{Shellwords.escape(log)} | mailx -a \"From: First Last <first.last@somewhere>\" -s \"#{subject}\" footprints@email"
                `#{cmd}`
                puts "Updating Ticket ##{issue} with commit log message"
        end
end
