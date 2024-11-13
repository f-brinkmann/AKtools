% This is an example for selecting the parameters of an N alternative
% forced coise experiment using AKnAFCstatistics. It outputs the minimally
% required number of trials to achieve user specified type I and type II
% errors and the number of correct answers above which the detection rate
% can be assumed to be significantly above the chance level.
% 
% For more information, refer to AKnAFCstatistics and [1]. For a brief
% reasoning regarding the parameter 'p_pop' refer to [2].
%
% [1] Les Leventhal: "Type I and type 2 errors in the statistical analysis
%     of listening tests." J. Audio Eng. Soc. 34(6):437-453 (1986).
% [2] Fabian Brinkmann, Alexander Lindau, and Stefan Weinzierl "On the
%     authenticity of individual dynamic binaural synthesis." J. Acoust.
%     Soc. Am, 142(4), 1784–1795 (2017). https://doi.org/10.1121/1.5005606
%
% 11/2024 - fabian.brinkmann@tu-berlin.de

% AKtools
% Copyright (C) 2016 Audio Communication Group, Technical University Berlin
% Licensed under the EUPL, Version 1.1 or as soon they will be approved by
% the European Commission - subsequent versions of the EUPL (the "License")
% You may not use this work except in compliance with the License.
% You may obtain a copy of the License at: 
% http://joinup.ec.europa.eu/software/page/eupl
% Unless required by applicable law or agreed to in writing, software 
% distributed under the License is distributed on an "AS IS" basis, 
% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either expressed or implied.
% See the License for the specific language governing  permissions and
% limitations under the License. 
close all; clear; clc

% user parameters ---------------------------------------------------------
% number of test conditions conditions
n_conditions = 3;

% guessing probability (1 / number of possible answers)
p_guess = 1/3;

% assumed detection probability in the population
p_pop = .9;

% Target value for alpha (type I) and beta (type II) error. Bonferroni
% corrected in this case.
alpha_error_target = .05 / n_conditions;
beta_error_target = alpha_error_target;

% iterative search for required number of trials --------------------------
% initial beta (type II) error
beta_error = [];

% intial number of trials
n_trials = 0;

% iterate over n_trials
while isempty(beta_error) || beta_error > beta_error_target
    n_trials = n_trials + 1;
    [n_crit, alpha_error, beta_error, power] = ...
        AKnAFCstatistics(p_guess, p_pop, n_trials, alpha_error_target);
end

% run again to get verbose output
AKnAFCstatistics(p_guess, p_pop, n_trials, alpha_error_target);
