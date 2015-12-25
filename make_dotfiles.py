import glob
import os
from shutil import copy
from argparse import ArgumentParser


# These are all the files that are within this directory which are end with the
# file extension `.dotfile`.
this_file_dir = os.path.dirname(os.path.abspath(__file__))
file_dir = os.path.join(this_file_dir, 'dotfiles')
FILES = glob.glob(os.path.join(file_dir, '*.dotfile'))


def move_files(files_selected, destination):
    '''
    Moves the files given to the destination. `files_selected` is expected to
    be a list of strings. `destination` is expected to be an absolute path to
    the folder where they should be placed. This does not have a return value.
    '''
    for name in files_selected:
        new_name = '.{0}'.format(os.path.basename(name).replace('.dotfile', ''))
        new_path = os.path.join(destination, new_name)
        old_path = os.path.join(destination, name)
        copy(old_path, new_path)
        print('Copied {0} => {1}\n'.format(old_path, new_path))


def ask_for_files():
    '''
    Asks the user to select which dotfiles to copy over. Returns a list of
    filenames as strings.
    '''
    return [name for name in FILES if should_move(name)]


def should_move(filename):
    '''
    Prompts the user to see whether or not they want to move the given
    filename. The only options which are considered to be valid are `y` or `n`.
    '''
    answer = None

    while not answer:
        answer = raw_input('Want to move `%s`? [y/n] ' % filename).lower()
        if not answer or (answer != 'y' and answer != 'n'):
            print('`%s` is not a valid answer.' % answer)
            answer = None

    return answer == 'y'


def just_do_it(args = {}):
    '''
    The main function of the application. It takes the arguments provided by
    the ArgumentParser to determine whether the program should copy every
    dotfile found within this directory or ask the user specifically which
    files to copy over. It also provides the option to directly copy the
    dotfile(s) to the user's home directory.
    '''

    files = ask_for_files() if args.pick_some_files else FILES
    destination = os.path.expanduser('~') if args.go_for_it else file_dir

    if len(files) > 0:
        move_files(files, destination)
        print('Successfully moved these files: [%s]' % str.join(', ', files))
    else:
        print('Moved no files.')


def build_arg_parser():
    '''
    Builds the argument parser to determine which options the user wants.
    '''
    description = 'Move your dotfiles from version control. This script \
            renames `my.dotfile` into `.my`. It either copies them within the \
            repo or moves them into the user\'s home directory.'
    parser = ArgumentParser(description=description)
    parser.add_argument('-p', '--pick', dest='pick_some_files',
                        action='store_true', help='Selecting this option will \
                                                   allow your to pick files \
                                                   to copy over.')
    parser.add_argument('-d', '--doit', dest='go_for_it', action='store_true',
                        help='Copy files to home directory')
    return parser

if __name__ == '__main__':
    parser = build_arg_parser()
    arguments = parser.parse_args()
    just_do_it(arguments)
