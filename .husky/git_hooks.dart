import 'dart:io';

/// Main entry point for Git Hooks
void main(List<String> arguments) {
  if (arguments.isEmpty) {
    print('\x1B[31mError: Hook type not specified\x1B[0m');
    exit(1);
  }

  // The hook type is determined by the script name (commit-msg, pre-commit, etc.)
  final hookName = arguments.first;
  final hookArgs = arguments.skip(1).toList();

  switch (hookName) {
    case 'commit-msg':
      if (!validateCommitMessage(hookArgs)) {
        exit(1);
      }
      break;
    case 'pre-commit':
      if (!runPreCommitChecks()) {
        exit(1);
      }
      break;
    default:
      print('\x1B[31mUnknown hook type: $hookName\x1B[0m');
      exit(1);
  }
}

bool validateCommitMessage(List<String> arguments) {
  print('Validating commit message...');

  if (arguments.isEmpty) {
    print('\x1B[31mNo commit message file provided.\x1B[0m');
    return false;
  }

  final commitMsgFile = arguments.first;
  final file = File(commitMsgFile);

  if (!file.existsSync()) {
    print('\x1B[31mCommit message file does not exist.\x1B[0m');
    return false;
  }

  final commitMessage = file.readAsStringSync().trim();

  // Commitlint pattern
  final conventionalCommitPattern = RegExp(
    r'^(feat|fix|docs|style|refactor|perf|test|build|ci|chore|revert|merge|rebase)(\(.+\))?: .+',
    caseSensitive: false,
    multiLine: true,
  );

  // Additional pattern to validate optional details (lines starting with -)
  final detailsPattern = RegExp(r'^- .+', multiLine: true);

  final lines = commitMessage.split('\n');
  final firstLine = lines.first.trim();

  // Primary validation: Check if first line matches required format
  if (!conventionalCommitPattern.hasMatch(firstLine)) {
    print('\x1B[31m❌ Commit message format validation failed.\x1B[0m');
    print('');
    print('Your commit message MUST follow this format:');
    print('  \x1B[33mtype: description\x1B[0m');
    print('  \x1B[33mtype(scope): description\x1B[0m');
    print('  \x1B[33m- detail one (optional)\x1B[0m');
    print('  \x1B[33m- detail two (optional)\x1B[0m');
    print('');
    print('Examples of valid commit messages:');
    print('  \x1B[32mfeat: add user login functionality\x1B[0m');
    print('  \x1B[32mfeat(auth): add user login functionality\x1B[0m');
    print(
        '  \x1B[32mfeat(scripts): add derry.yaml for command management\x1B[0m');
    print('  \x1B[32mfix(ui): resolve item calculation issue\x1B[0m');
    print('  \x1B[32mdocs(api): update API documentation\x1B[0m');
    print('  \x1B[32mmerge(dev): merge development branch into main\x1B[0m');
    print('  \x1B[32mrebase(feature): rebase feature branch onto main\x1B[0m');
    print('');
    print('Example with details:');
    print('  \x1B[32mfeat(auth): implement user authentication\x1B[0m');
    print('  \x1B[32m- add login form validation\x1B[0m');
    print('  \x1B[32m- integrate OAuth providers\x1B[0m');
    print('  \x1B[32m- add session management\x1B[0m');
    print('');
    print('Valid types:');
    print('  \x1B[36mfeat\x1B[0m:     A new feature');
    print('  \x1B[36mfix\x1B[0m:      A bug fix');
    print('  \x1B[36mdocs\x1B[0m:     Documentation only changes');
    print(
        '  \x1B[36mstyle\x1B[0m:    Changes that do not affect the meaning of the code');
    print(
        '  \x1B[36mrefactor\x1B[0m: A code change that neither fixes a bug nor adds a feature');
    print('  \x1B[36mperf\x1B[0m:     A code change that improves performance');
    print(
        '  \x1B[36mtest\x1B[0m:     Adding missing tests or correcting existing tests');
    print(
        '  \x1B[36mbuild\x1B[0m:    Changes that affect the build system or external dependencies');
    print(
        '  \x1B[36mci\x1B[0m:       Changes to CI configuration files and scripts');
    print(
        '  \x1B[36mchore\x1B[0m:    Other changes that don\'t modify src or test files');
    print('  \x1B[36mrevert\x1B[0m:   Reverts a previous commit');
    print('  \x1B[36mmerge\x1B[0m:    Merge branches or pull requests');
    print(
        '  \x1B[36mrebase\x1B[0m:   Rebase operations and branch reorganization');
    print('');
    print(
        'Valid scopes examples: auth, ui, api, db, scripts, config, docs, test, my-feature, API v2, etc.');
    print('');
    print(
        '⚠️  Note: Empty parentheses like "feat(): description" are NOT allowed');
    print(
        '💡 Tip: Scope can contain any text: feat(my custom scope): description');
    print('');
    print('Your message was: \x1B[31m"$firstLine"\x1B[0m');
    return false;
  }

  // Validate detail lines (if present)
  if (lines.length > 1) {
    for (int i = 1; i < lines.length; i++) {
      final line = lines[i].trim();
      if (line.isNotEmpty && !detailsPattern.hasMatch(line)) {
        print('\x1B[31m❌ Invalid detail line format on line ${i + 1}.\x1B[0m');
        print('');
        print('Detail lines must start with "- " followed by description:');
        print('  \x1B[33m- your detail here\x1B[0m');
        print('');
        print('Invalid line: \x1B[31m"$line"\x1B[0m');
        return false;
      }
    }
  }

  print('\x1B[32m✅ Commit message format is valid!\x1B[0m');
  return true;
}

bool runPreCommitChecks() {
  print('Running pre-commit checks...');

  // Read configuration from YAML file
  final configFile = File('.husky/hook_config.yaml');
  bool analyzeEnabled = false;
  bool formatEnabled = false;

  if (configFile.existsSync()) {
    final configContent = configFile.readAsStringSync();

    // Parse configuration using regular expressions for better portability
    final analyzeMatch =
        RegExp(r'analyze:\s*(true|false)').firstMatch(configContent);
    final formatMatch =
        RegExp(r'format:\s*(true|false)').firstMatch(configContent);

    analyzeEnabled = analyzeMatch != null && analyzeMatch.group(1) == 'true';
    formatEnabled = formatMatch != null && formatMatch.group(1) == 'true';
  }

  // Run flutter analyze
  if (analyzeEnabled) {
    print('\x1B[33mRunning Flutter analyze...\x1B[0m');
    final analyzeResult = Process.runSync(
        'flutter',
        [
          'analyze',
          '--no-fatal-infos',
        ],
        runInShell: true);

    if (analyzeResult.exitCode != 0) {
      print(
        '\x1B[31mFlutter analyze found issues. Please fix them before committing.\x1B[0m',
      );
      print(analyzeResult.stdout);
      return false;
    }
  } else {
    print('\x1B[33mFlutter analyze check is disabled.\x1B[0m');
  }

  // Run dart format check
  if (formatEnabled) {
    print('\x1B[33mRunning Dart format verification...\x1B[0m');

    // Only our own sources: generated files follow the generator's formatting,
    // and .dart_tool / build / platform folders are not ours to format.
    final findResult = Process.runSync(
        'find',
        [
          'lib',
          'test',
          '-name',
          '*.dart',
          '-type',
          'f',
          '-not',
          '-name',
          '*.g.dart',
          '-not',
          '-name',
          '*.freezed.dart',
          '-not',
          '-path',
          '*/generated/*',
        ],
        runInShell: true);

    if (findResult.exitCode != 0 ||
        findResult.stdout.toString().trim().isEmpty) {
      print('\x1B[32mNo files to check for formatting.\x1B[0m');
    } else {
      final files = findResult.stdout.toString().trim().split('\n');
      final filesToCheck = files.where((file) {
        final content = File(file).readAsStringSync();
        return !content.contains('@git-hooks-test-file');
      }).toList();

      if (filesToCheck.isEmpty) {
        print('\x1B[32mNo files to check for formatting.\x1B[0m');
      } else {
        final formatResult = Process.runSync(
            'dart',
            [
              'format',
              '--output=none',
              '--set-exit-if-changed',
              ...filesToCheck,
            ],
            runInShell: true);

        if (formatResult.exitCode != 0) {
          print(
            '\x1B[31mDart format check failed. Please format your code before committing:\x1B[0m',
          );
          print('Run: dart format .');
          return false;
        }
      }
    }
  } else {
    print('\x1B[33mDart format check is disabled.\x1B[0m');
  }

  print('\x1B[32mAll checks passed!\x1B[0m');
  return true;
}