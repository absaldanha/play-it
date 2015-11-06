module PlayIt
  module Extraction
    class Extractor
      class ExtractionError < StandardError; end

      class << self
        def extract_features(music_path)
          output = run_extraction(escaped_path(music_path))
          parse_result(output)
        end

        private

        def escaped_path(path)
          Shellwords.escape(path)
        end

        def run_extraction(music_path)
          tempfile = Tempfile.new(['tmp', '.json'], '.')

          execute_binary(music_path, tempfile.path)
          read_results(tempfile)
        ensure
          tempfile.close
          tempfile.unlink
        end

        def execute_binary(music_path, json_path)
          binary_command(music_path, json_path).run
        rescue => e
          raise ExtractionError, "Failed to execute extraction: #{e.message}"
        end

        def binary_command(music_path, json_path)
          profile = PlayIt::Config.profile_path
          Cocaine::CommandLine.path = PlayIt::Config.command_path
          Cocaine::CommandLine.new(
            "streaming_extractor_music #{music_path} #{json_path} #{profile}"
          )
        end

        def read_results(results)
          results.rewind
          results.read
        end

        def parse_result(results)
          Parser.parse(JSON.parse(results))
        end
      end
    end
  end
end
