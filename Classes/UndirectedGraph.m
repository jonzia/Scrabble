classdef UndirectedGraph

    % ---------------------------------------------------------------------
    % Structure undirected graph for visualization.
    % - grid: Display data as grid
    % - circle: Display data as circle
    % ---------------------------------------------------------------------
    enumeration
        grid, circle
    end

    methods

        function visualize(obj, A, varargin)

            % -------------------------------------------------------------
            % Display graph based on type.
            %
            % Input arguments
            % A             [NxN]   Adjacency matrix
            % varargin{1}   fig     Figure handle (optional)
            % -------------------------------------------------------------

            % Parse varargin
            useHandle = false;
            if ~isempty(varargin) && isa(varargin{1}, 'matlab.ui.Figure')
                fig = varargin{1}; useHandle = true;
            end

            % Calculate number of vertices
            N = size(A, 1);

            switch obj
                case UndirectedGraph.grid

                    % If N is a perfect square...
                    if mod(sqrt(N), 1) == 0
                        % Set number of rows and columns
                        numRows = sqrt(N); numCols = sqrt(N);
                    end

                    % If N is prime...
                    if length(divisors(N)) == 2
                        % Plot a circle
                        UndirectedGraph.circle.visualize(A);
                        return
                    end

                    % Obtain divisors of N: if a number has several
                    % divisors, select dimensions to approximate square
                    if length(divisors(N)) > 2 && mod(sqrt(N), 1) ~= 0

                        % Get divisors of N
                        div = divisors(N); med = median(div);
                        % Get two indices closest to median
                        [~, idx] = sort(abs(div - med));
                        numRows = div(idx(1));
                        numCols = div(idx(2));

                    end

                    % Set placeholder for coordinates
                    coords = zeros(N, 2);

                    % Populate coordinates
                    counter = 1;
                    for i = 1:numRows
                        for j = 1:numCols
                            coords(counter, :) = [i j];
                            counter = counter + 1;
                        end
                    end

                    % Plot points
                    if ~useHandle; figure; else; figure(fig); end; hold on; grid on;
                    scatter(coords(:, 1), coords(:, 2), 'ok', 'filled', 'SizeData', 20)

                    % Plot lines
                    B = triu(A);    % Get upper triangular of A
                    for i = 1:N
                        for j = 1:N

                            % Skip self reference
                            if i == j; continue; end

                            % Create a connection between i and j
                            if B(i,j) == 1
                                plot([coords(i, 1) coords(j, 1)], [coords(i, 2) coords(j, 2)], '-k')
                            end

                        end
                    end
                    
                    % xlim([1, numCols]); ylim([1, numRows]);

                case UndirectedGraph.circle

                    % Get polar coordinates of points in radians
                    rads = linspace(0, 2*pi, N+1); rads = rads(:); rads(end) = [];
                    [x, y] = pol2cart(rads, ones(N, 1));    % Cartesian

                    % Plot points
                    if ~useHandle; figure; else; figure(fig); end; hold on; grid on;
                    scatter(x, y, 'ok', 'filled', 'SizeData', 20)

                    % Plot lines
                    B = triu(A);    % Get upper triangular of A
                    for i = 1:N
                        for j = 1:N

                            % Skip self reference
                            if i == j; continue; end

                            % Draw line if A(i,j) = 1
                            if B(i,j) == 1
                                plot([x(i) x(j)], [y(i) y(j)], '-k')
                            end

                        end
                    end

            end

        end

        function A = generateGrid(obj, N, varargin)

            % -------------------------------------------------------------
            % Generates a grid adjacency matrix of dimension N^2 x N^2.
            %
            % Input arguments:
            % N             Int     Square root of number of vertices
            % varargin{1}   Bool    Visualize graph?
            % varargin{2}   fig     Figure handle
            % -------------------------------------------------------------

            % Parse varargin
            % Set defaults
            visualize = false; useHandle = false;
            if ~isempty(varargin)
                if isa(varargin{1}, 'logical'); visualize = varargin{1}; end
                if length(varargin) > 1 && isa(varargin{2}, 'matlab.ui.Figure')
                    fig = varargin{2}; useHandle = true;
                end
            end

            % Generate placeholder
            A = eye(N^2);

            % Populate adjacency
            for i = 1:N^2
                for j = 1:N^2
                    if j == i+N || j == i-N; A(i,j) = 1; end
                    if mod(i,N) ~= 0 && (j == i+1 || j == i-1); A(i,j) = 1; end
                end
            end

            % Plot graph
            if visualize
                switch obj
                    case UndirectedGraph.grid
                        if ~useHandle; UndirectedGraph.grid.visualize(A); end
                        if useHandle; UndirectedGraph.grid.visualize(A, fig); end
                    case UndirectedGraph.circle
                        if ~useHandle; UndirectedGraph.circle.visualize(A); end
                        if useHandle; UndirectedGraph.circle.visualize(A, fig); end
                end
            end

        end

    end

end