from cmd2 import Cmd, Cmd2ArgumentParser


# class FABulousCmdParser:




tile_list_parser = Cmd2ArgumentParser()
tile_list_parser.add_argument("tile", type=str, help="A list of tile want to perform action on", nargs="+")