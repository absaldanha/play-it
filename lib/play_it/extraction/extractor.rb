module PlayIt
  module Extraction
    class Extractor
      class ExtractionError < StandardError; end

      class << self
        def extract_features(music_path)
          output = run_extraction(music_path)
          parse_result(output)
        end

        private

        def run_extraction(music_path)
          result_file = open_tempfile
          execute_binary(music_path, result_file.path)
          read_results(result_file)
        end

        def open_tempfile
          Tempfile.new(['tmp', '.json'], '.')
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
