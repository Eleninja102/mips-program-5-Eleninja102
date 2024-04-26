#!/usr/bin/env python3

def decode_instruction(hex_num):
    print("\tInside decode_instruction")
    opcode = 0
    # TODO do the decoding here
    return opcode

def print_hex_info(message, hex_num):
    print("Inside Hex Info")
    print(message, hex_num)
    # Call decode_instruction here
    decode_instruction(hex_num)


def main():
    process = "Now processing"
    instructions = [0x01095020, 		# add $t2, $t0, $t1
					0x1220002C,  		# beqz $s1, label
					0x3C011001,		# lw $a0, label($s0)
					0x24020004,		# li $v0, 4
					0x08100002]		# j label

    for index in range(5):
        print_hex_info(process, instructions[index])


if __name__ == '__main__':
    main()