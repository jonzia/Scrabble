classdef ErrorType
    
    % Enumeration for type of error
    % dataType - Expected different data type
    % outOfRange - Number out of accepted range
    enumeration
        dataType, outOfRange
    end
    
    methods
        
        % Display error message
        function message(obj, filename, varargin)

            % -------------------------------------------------------------
            % This function displays error messages.
            %
            % Input arguments
            % filename      String	Name of file in which error occurred
            % varargin
            %   ErrorType.dataType: {char, double, char}
            %       Expected class -> argument # -> received class
            %   ErrorType.outOfRange: {double, double, double}
            %       Argument -> lower range -> upper range
            % -------------------------------------------------------------

            % Initialize varargin error message
            vararginErrorMessage = "Error in ErrorType.message(): Please see documentation for proper input formatting.";

            % Ensure proper data type for filename
            if ~isa(filename, 'string')
                disp("Error in ErrorType.message(): Expected input of type string in Argument 1; received type " + ...
                    string(class(filename)) + "."); return
            end

            switch obj
                % ---------------------------------------------------------
                % DATA TYPE ERROR
                % ---------------------------------------------------------
                case ErrorType.dataType

                    % Data type error. Parse varargin.
                    if isempty(varargin) || length(varargin) ~= 3 || ~isa(varargin{1}, 'char') || ...
                            ~isa(varargin{2}, 'double') || ~isa(varargin{3}, 'char')
                        disp(vararginErrorMessage); return
                    end

                    % Display error message
                    disp("Error in " + filename + ": Expected input of type " + string(varargin{1}) + ...
                        " in Argument " + string(varargin{2}) + "; received type " + ...
                        string(varargin{3}) + ".");
                    return

                % ---------------------------------------------------------
                % OUT OF RANGE ERROR
                % ---------------------------------------------------------
                case ErrorType.outOfRange

                    % Out of range error. Parse varargin
                    if isempty(varargin) || length(varargin) ~= 3 || ~isa(varargin{1}, 'double') || ...
                            ~isa(varargin{2}, 'double') || ~isa(varargin{3}, 'double')
                        disp(vararginErrorMessage); return
                    end

                    % Display error message
                    disp("Error in " + filename + ": Input in Argument " + string(varargin{1}) + ...
                        " out of the range [" + string(varargin{2}) + ", " + string(varargin{3}) + "].");
                    return

                % ---------------------------------------------------------
                % UNSPECIFIED ERROR
                % ---------------------------------------------------------
                otherwise
                    % Display generic error message
                    disp("Error in " + filename + ": Unspecified error type."); return
                    
            end
        end
        
    end
    
end