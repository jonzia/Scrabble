function varargout = assign(filename, argNo, input, desired, varargin)

% -------------------------------------------------------------------------
% Checks that an input to the function has the proper data type. If yes,
% displays error message and returns true. Otherwise returns false. To
% second output argument, returns input if no error. Otherwise, returns
% value specified in varargin. If no varargin provided, returns blank.
% Optionally, if the input is a double, checks if the double is in the
% desired range; if not, returns default output.
%
% Input arguments
% filename      String      File/function name being checked
% argNo         Int         Argument number being checked
% input         obj         Object inputted as argument
% desired       Char        Desired class
% varargin{1}   any         Output if error is present
% varargin{2}   [Int, Int]  Range, if desired input is a double
% -------------------------------------------------------------------------

% Set defaults
% varargout{1}  output
% varargout{2}  is error?
varargout{1} = input; varargout{2} = true;

% Check type of inputs; if error, return
if ~isa(filename, 'string'); ErrorType.dataType.message("utils.assign()", 'string', 1, class(filename)); return; end
if ~isa(argNo, 'double'); ErrorType.dataType.message("utils.assign()", 'double', 2, class(argNo)); return; end
if ~isa(desired, 'char'); ErrorType.dataType.message("utils.assign()", 'char', 4, desired); return; end

% Compare input object to desired object type
if ~isa(input, desired)
    % Display error message and return true; if varargin provided, write to
    % output
    ErrorType.dataType.message(filename, desired, argNo, class(input));
    if ~isempty(varargin); varargout{1} = varargin{1}; end; return
else
    
    % If the desired output is a double, check range
    if strcmp(desired, 'double') && ~isempty(varargin) && length(varargin) == 2 && ...
            length(varargin{2}) == 2
        % If the input is out of range, display an error message and return
        % true; if varargin provided, write to output
        range = varargin{2};
        if input < range(1) || input > range(2)
            ErrorType.outOfRange.message(filename, argNo, range(1), range(2));
            if ~isempty(varargin); varargout{1} = varargin{1}; end; return
        end
    end
    
    % If no further error, write false to output and pass through input
    varargout{2} = false; return

end

end

