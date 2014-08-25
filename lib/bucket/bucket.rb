module Bucket
  class Bucket
    def initialize
      @stats = {
        users: {
          genders: {}
        },
        last_vars: {

        }
      }
    end

    # This method is called when a ChatMessage is received.
    def chatMessageReceived(chat_message)
      @last_activity = Time.now
      who = chat_message.get_sender
      chat = chat_message.chat
      if config[:ignore].include?(who)
        log("Ignoring #{who} in #{chat}")
        return
      end

      content = chat_message.get_content

      say(chat, "#{who} said #{content}")
      log("#{who} said #{content}")
      parse(chat_message)
    end

    # This method is called with a ChatMessage is sent.
    def chatMessageSent(_chat_message)
      # I don't care about this method, but I must implement it.
    end

    def say(channel, message)
      channel.send(message)
    end

    def act(channel, action)
      channel.send("/me #{action}")
    end

    def log(msg)
      puts msg
    end

    def parse(chat_message)
      bag = {}
      bag[:msg] = chat_message.get_content.strip
      bag[:orig] = chat_message.get_content
      bag[:chl] = chat_message.chat
      bag[:who] = chat_message.get_sender.to_s
      bag = get_subject_and_object?(bag)
      bag[:op] = op?(bag)
      bag[:editable] = editable?(bag)

      @stats[:last_vars][chat_message.chat] ||= {}

      # mario: Here we go!
      # The logic here:
      #   Try to do each thing in turn.
      #   Each method contains its own preconditions.
      #   If the precons are met, it executes its logic and
      #     returns `true`, skipping the rest of the methods.
      #   If not, it skips its logic and returns `false`,
      #      leading to the next method
      if command_matches? bag
      elsif edit_fact? bag
      elsif lookup_factoid? bag
      elsif list_plugins? bag
      elsif load_plugin? bag
      elsif unload_plugin? bag
      elsif literal? bag
      elsif delete_item? bag
      elsif delete_fact? bag
      elsif shut_up? bag
      elsif unshut_up? bag
      elsif join_part_channel? bag
      elsif list_ignored? bag
      elsif fix_syllables? bag
      elsif ignore_person? bag
      elsif un_exclude_person? bag
      elsif un_protect_fact? bag
      elsif undo_last? bag
      elsif merge_facts? bag
      elsif alias_facts? bag
      elsif lookup_fact? bag
      elsif forget_last? bag
      elsif what_was_that? bag
      elsif asked_for_random? bag
      elsif asked_for_stats? bag
      elsif stat_var? bag
      elsif restart? bag
      elsif set_var? bag
      elsif get_var? bag
      elsif list_vars? bag
      elsif list_specific_var? bag
      elsif remove_value? bag
      elsif add_value? bag
      elsif create_var? bag
      elsif remove_var? bag
      elsif set_var_type? bag
      elsif asked_for_detailed_inventory? bag
      elsif asked_for_inventory? bag
      elsif set_gender? bag
      elsif ask_gender? bag
      elsif reply_to_uses? bag
      elsif lookup_tla? bag
      else
        lookup bag
      end
    end # parse

    def command_matches?(_bag)
    end

    def edit_fact?(_bag)
      false
    end

    def lookup_factoid?(_bag)
      false
    end

    def list_plugins?(_bag)
      false
    end

    def load_plugin?(_bag)
      false
    end

    def unload_plugin?(_bag)
      false
    end

    def literal?(_bag)
      false
    end

    def delete_item?(_bag)
      false
    end

    def delete_fact?(_bag)
      false
    end

    def shut_up?(_bag)
      false
    end

    def unshut_up?(_bag)
      false
    end

    def join_part_channel?(_bag)
      false
    end

    def list_ignored?(_bag)
      false
    end

    def fix_syllables?(_bag)
      false
    end

    def ignore_person?(_bag)
      false
    end

    def un_exclude_person?(_bag)
      false
    end

    def un_protect_fact?(_bag)
      false
    end

    def undo_last?(_bag)
      false
    end

    def merge_facts?(_bag)
      false
    end

    def alias_facts?(_bag)
      false
    end

    def lookup_fact?(_bag)
      false
    end

    def forget_last?(_bag)
      false
    end

    def what_was_that?(_bag)
      false
    end

    def asked_for_random?(_bag)
      false
    end

    def asked_for_stats?(_bag)
      false
    end

    def stat_var?(_bag)
      false
    end

    def restart?(_bag)
      false
    end

    def set_var?(_bag)
      false
    end

    def get_var?(_bag)
      false
    end

    def list_vars?(_bag)
      false
    end

    def list_specific_var?(_bag)
      false
    end

    def remove_value?(_bag)
      false
    end

    def add_value?(_bag)
      false
    end

    def create_var?(_bag)
      false
    end

    def remove_var?(_bag)
      false
    end

    def set_var_type?(_bag)
      false
    end

    def asked_for_detailed_inventory?(_bag)
      false
    end

    def asked_for_inventory?(_bag)
      false
    end

    def set_gender?(_bag)
      false
    end

    def ask_gender?(_bag)
      false
    end

    def reply_to_uses?(_bag)
      false
    end

    def lookup_tla?(_bag)
      false
    end

    def lookup(bag)
      unless bag[:addressed] || bag[:msg].length >= config[:minimum_length] || bag[:msg] == '...'
        return false
      end

      fact = Fact.by_trigger(bag[:msg])
      return unless fact

      tidbit = expand(bag, fact.tidbit)
      return true unless tidbit

      case fact.verb
      when '<reply>'
        say(bag[:chl], tidbit)
      when "'s"
        say(bag[:chl], "#{bag[:msg]}'s #{tidbit}")
      when '<action>'
        act(bag[:chl], tidbit)
      else
        if bag[:msg].casecomp('bucket') == 0 && fact.verb.casecomp('is') == 0
          bag[:msg] = 'I'
          fact.verb = 'am'
        end
        say(bag[:chl], [bag[:msg], fact.verb, fact.tidbit].join(' '))
      end
          end

    def expand(bag, msg)
      who, chl, editable, to = bag[:who], bag[:chl], bag[:editable], bag[:to]

      gender = @stats[:users][:genders][who.downcase] || :androgynous
      target = who

      while msg =~ /(?<!\\)(\$who\b|\${who})/i
        cased = set_case(Regexp.last_match[1], who)
        break unless msg.sub!(/(?<!\\)(?:\$who\b|\${who})/i, cased)
        @stats[:last_vars][bag[:chl]][who] = who
      end

      if msg =~ /(?<!\\)(?:\$someone\b|\${someone})/i
        stats[:last_vars][chl][:someone] = []
        while msg =~ /(?<!\\)(\$someone\b|\${someone})/i
          rand_nick = someone(chl, who, to)
          cased     = set_case(Regexp.last_match[1], rand_nick)
          break unless msg.sub!(/\$someone\b|\${someone}/i, cased)
          @stats[:last_vars][chl][:someone] << rand_nick

          gender = @stats[:users][:genders][rand_nick.downcase]
          target = rand_nick
        end
      end

      while msg =~ /(?<!\\)(\$to\b|\${to})/i
        unless to
          to = someone(chl, who)
        end
        cased = set_case(Regexp.last_match[1], to)
        break unless msg.sub!(/(?<!\\)(?:\$to\b|\${to})/i, cased)
        @stats[:last_vars][chl][:to] << to

        gender = stats[:users][:genders][to.downcase]
        target = to
      end

      @stats[:last_vars][chl][:item] = []
      while msg =~ /(?<!\\)(\$(give)?item|\${(give)?item})/i
        give_flag = Regexp.last_match[2] || (Regexp.last_match[3] ? 'give' : '')
        if @inventory
          give = editable && give_flag
          item = get_item(give)
          cased = set_case(Regexp.last_match[1], item)
          item_given = give ? "#{item} given" : item
          @stats[:last_vars][chl][:item] << item_given
          break unless msg.sub!(/(?<!\\)(?:\$${giveflag}item|\${${giveflag}item})/i, cased)
        else
          msg.sub!(/(?<!\\)(?:\$${giveflag}item|\${${giveflag}item})/i, 'bananas')
          @stats[:last_vars][chl][:item] << '(bananas)'
        end
      end

      @stats[:last_vars][chl][:new_item] = []
      while msg =~ /(?<!\\)(\$newitem|\${newitem})/i
        if editable
          new_item = @random_items.pop || 'bananas'
          rc, dropped = put_item(new_item, 1)
          if rc == 2
            @stats[:last_vars][chl][:dropped] = dropped
            cached_reply(chl, who, dropped, 'drops item')
            return
          end

          cased = set_case(Regexp.last_match[1], new_item)
          break unless msg.sub!(/(?<!\\)(?:\$newitem|\${newitem})/i, cased)
          @stats[:last_vars][chl][:new_item] << new_item
        else
          msg.gsub!(/(?<!\\)(?:\$newitem|\${newitem})/i, 'bananas')
        end
      end

      if gender
        # TODO: bucket.pl:3200
      end

      # TODO: special cases
      # bucket.pl:3222

      msg
    end

    def set_case(var, value)
      # values that already include capitals are never modified
      return value if value =~ /[A-Z]/

      var.gsub!(/\W+/, '')
      return value.upcase if var =~ /^[A-Z_]+$/
      return value.title if var =~ /^[A-Z][a-z_]+$/
      value
    end

    def decommify(msg)
      msg.gsub(/\s*,\s*/, ' ').gsub(/\s\s+/, ' ')
    end

    # Sets :addressed and :to
    def get_subject_and_object?(bag)
      @addressed_regex ||= Regexp.new(/
    ^ #{Regexp.quote(config[:nick])}  # If the line starts with the bot's nickname
    [:,]\s*                          # and is followed by a colon or comma,
    |                                # or
    ^ @                              # if the line starts with an at-symbol
    #{Regexp.quote(config[:nick])}    # the nickname
    \s+                              # and whitespace
    |                                # or
    ,\s+                             # the line ends with a comma, then whitespace
    #{Regexp.quote(config[:nick])}\W+ # then the bot's nickname
    /ix)                             # case-insensitive
      @to_regex ||= Regexp.new(/
    ^(\S+)   # If the line starts with the bot's nickname
    [:,]\s*  # and is followed by a colon or comma,
    |        # or
    ^ @      # if the line starts with an at-symbol
    (\S+)    # the nickname
    \s+      # and whitespace
    /ix)     # case-insensitive

      if bag[:msg].sub!(@addressed_regex, '')
        bag[:addressed] = true
        bag[:to] = config[:nick]
      elsif bag[:msg].sub!(@to_regex, '')
        bag[:to] = Regexp.last_match[1]
      end
      bag
    end

    # returns a boolean
    def op?(bag)
      @config[:ops].include?(bag[:who])
    end

    # returns a boolean
    def editable?(_bag)
      true
    end

    def config
      @config ||= {
        autoload_plugins: [],
        band_name: 0.05,
        band_var: 'band',
        config_file: 'bucket.yml',
        database_file: 'bucket.sqlite3',
        ex_to_sex: 1,
        file_input: nil,
        idle_source: 'factoid',
        ignore: [],
        increase_mute: 60,
        inventory_preload: 5,
        inventory_size: 20,
        item_drop_rate: 3,
        lookup_tla: 10,
        max_sub_length: 80,
        minimum_length: 4,
        nick: 'Bucket',
        ops: %w(mrmkenyon mkenyonzynga),
        random_item_cache_size: 20,
        random_wait: 3,
        repeated_queries: 5,
        timeout: 60,
        tumblr_name: 50,
        user_activity_timeout: 360,
        uses_reply: 5,
        value_cache_limit: 1000,
        var_limit: 3,
        www_root: nil,
        www_url: nil,
        your_mom_is: 0.05
      }
    end

    def stats
      @stats ||= {}
    end

    def gender_vars
      @gender_vars ||= {
        subjective: {
          :male        => 'he',
          :female      => 'she',
          :androgynous => 'they',
          :inanimate   => 'it',
          :"full name" => '%N',
          :aliases     => %w(he she they it heshe shehe)
        },
        objective: {
          :male        => 'him',
          :female      => 'her',
          :androgynous => 'them',
          :inanimate   => 'it',
          :"full name" => '%N',
          :aliases     => %w(him her them himher herhim)
        },
        reflexive: {
          :male        => 'himself',
          :female      => 'herself',
          :androgynous => 'themself',
          :inanimate   => 'itself',
          :"full name" => '%N',
          :aliases     =>
          %w(himself herself themself itself himselfherself herselfhimself)
        },
        possessive: {
          :male        => 'his',
          :female      => 'hers',
          :androgynous => 'theirs',
          :inanimate   => 'its',
          :"full name" => "%N's",
          :aliases     => %w(hers theirs hishers hershis)
        },
        determiner: {
          :male        => 'his',
          :female      => 'her',
          :androgynous => 'their',
          :inanimate   => 'its',
          :"full name" => "%N's",
          :aliases     => %w(their hisher herhis)
        }
      }
    end
  end
end
